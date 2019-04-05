
-- unit:: Any -> ()
-- unit x = (x, "")

-- lift f x = (f x, "")



-- 3
-- -- Show that lift f * lift g = lift (f.g)

-- Let's rewrite lift f and lift g as their own terms f' and g', respectively
-- lift f = unit . f
-- f' = lift f
-- Similarly,
-- lift g = unit . g
-- g' = lift
-- Then we can say that
-- f' * g' = (bind f') . (bind g')  as indi in POPO

-- Unwrap Left side
-- (lift f * lift g) (x, xs)
-- = (bind (lift f)) . (bind (lift g)) (x, xs)
-- = bind (lift f) (bind (lift g) (x, xs))      We'll try to eval right most side first
-- = bind (lift f) (gx, xs++gs)                 Fnx of g is applied to x and we get the rest xs++gs        
--   where
--     (gx, gs) = (lift g) x

-- = bind (lift f) (gx, xs++gs)     gs are nothing more than "" so can do following
--   where
--     (gx, gs) = (g x, "")

-- -- Rewrite prev statement as
-- = bind (lift f) (g x, xs)   

-- --  Unwrap the applicative eval of f applied to the output of g operated on x which is x fed to f
-- = (fx, xs++fs)
--   where
--     (fx, fs) = (lift f) gx
-- = (fx, xs++fs)
--   where
--     (fx, fs) = (f gx, "")
-- = (fx, xs)
--   where
--     (fx, fs) = (f (g x), "") --

-- = (f (g x), xs) --

-- bind f' (gx,gs) = (fx, gs++fs)
--    where
--      (fx,fs) = f' gx



-- -- Unwrap right side of equality
-- bind (lift (f.g)) (x, xs)
-- = (hx, xs++hs)
--   where
--     (hx, hs) = (lift (f.g)) x

-- = (hx, xs++hs)
--   where
--     (hx, hs) = ((f.g) x, "")  --

-- = ((f (g x)), xs) --



-- 6
-- -- Show that f * unit = unit * f = f and lift f * lift g = lift (f.g)

