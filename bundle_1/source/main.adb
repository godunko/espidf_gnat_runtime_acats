
with Group_A;
with Group_C2;
with Group_C3;
with Group_CXA;
with Group_CXB;
with Group_CXC;
with Group_CXF;
with Group_CXG;

with Debug;

procedure Main is
   procedure ESP_Restart
     with Import, Convention => C, External_Name => "esp_restart";

begin
   Debug.Print_Heap_Info;
   Debug.Install_Heap_Failed_Alloc_Callback;

   Group_A;
   Group_C2;
   Group_C3;
   Group_CXA;
   Group_CXB;
   Group_CXC;
   Group_CXF;
   Group_CXG;

   Debug.Print_Heap_Info;
   ESP_Restart;
end Main;
