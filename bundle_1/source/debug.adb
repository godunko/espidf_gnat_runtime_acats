
with Interfaces.C.Strings;

package body Debug is

   type esp_err_t is new Interfaces.C.int;

   ESP_OK : constant esp_err_t := 0;

   type esp_alloc_failed_hook_t is
      access procedure
        (size          : Interfaces.C.size_t;
         caps          : Interfaces.Unsigned_32;
         function_name : Interfaces.C.Strings.chars_ptr);

   function heap_caps_register_failed_alloc_callback
     (callback : esp_alloc_failed_hook_t) return esp_err_t
     with Import, Convention => C,
          External_Name => "heap_caps_register_failed_alloc_callback";

   procedure heap_caps_print_heap_info (caps : Interfaces.Unsigned_32)
     with Import, Convention => C,
          External_Name => "heap_caps_print_heap_info";

   procedure alloc_failed_callback
     (size          : Interfaces.C.size_t;
      caps          : Interfaces.Unsigned_32;
      function_name : Interfaces.C.Strings.chars_ptr);

   ---------------------------
   -- alloc_failed_callback --
   ---------------------------

   procedure alloc_failed_callback
     (size          : Interfaces.C.size_t;
      caps          : Interfaces.Unsigned_32;
      function_name : Interfaces.C.Strings.chars_ptr) is
   begin
      heap_caps_print_heap_info (0);
   end alloc_failed_callback;

   ----------------------------------------
   -- Install_Heap_Failed_Alloc_Callback --
   ----------------------------------------

   procedure Install_Heap_Failed_Alloc_Callback is
   begin
      if heap_caps_register_failed_alloc_callback
           (alloc_failed_callback'Access) /= ESP_OK
      then
         null; --  Failed to register callback, but we have no way to report this.
      end if;
   end Install_Heap_Failed_Alloc_Callback;

   ---------------------
   -- Print_Heap_Info --
   ---------------------

   procedure Print_Heap_Info is
   begin
      heap_caps_print_heap_info (0);
   end Print_Heap_Info;

end Debug;