
procedure Main is
   procedure ESP_Restart
     with Import, Convention => C, External_Name => "esp_restart";

begin
   ESP_Restart;
end Main;
