with Interfaces;

package TOS is
   subtype Int16 is integer range -2 ** 15 .. 2 ** 15 - 1;
   subtype Uint16 is Interfaces.Unsigned_16;
end TOS;