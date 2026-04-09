with A22006B;
with A22006C;
with A22006D;
--  with A26007A;
with A27003A;
with A29003A;
with A2A031A;
with A33003A;
with A34017C;
with A35101B;
with A35402A;
with A35801F;
with A35902C;
with A38106D;
with A38106E;
with A49027A;
with A49027B;
with A49027C;
with A54B01A;
with A54B02A;
with A55B12A;
with A55B13A;
with A55B14A;
with A71004A;
with A73001I;
with A73001J;
with A74105B;

procedure Main is
   procedure ESP_Restart
     with Import, Convention => C, External_Name => "esp_restart";

begin
   A22006B;
   A22006C;
   A22006D;
   --  A26007A;
   A27003A;
   A29003A;
   A2A031A;
   A33003A;
   A34017C;
   A35101B;
   A35402A;
   A35801F;
   A35902C;
   A38106D;
   A38106E;
   A49027A;
   A49027B;
   A49027C;
   A54B01A;
   A54B02A;
   A55B12A;
   A55B13A;
   A55B14A;
   A71004A;
   A73001I;
   A73001J;
   A74105B;

   ESP_Restart;
end Main;
