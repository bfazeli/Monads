
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



-- 6 / 9
-- -- Show that f * unit = unit * f = f and lift f * lift g = lift (f.g)
-- Will show f * unit = unit * f = f since the right half was proved above
--
-- Simply defining the various terms
-- f :: a -> b
-- f' :: a -> m a
-- unit :: a -> m a
-- lift f = unit . f
-- f' = lift f
--
-- f * unit = unit * f = f      can be rewritten as: 
-- f'* unit = unit * f' = bind f'
--
--
-- Establish what it means to eval f' * g' on some xs
-- bind can be applied to f' and g' resp
-- = ((bind f') . (bind g')) xs
-- 
-- What does it mean to bind a fnx to xs
-- It's simply applying that fnx to all elements of xs recursively and flattening it
-- Thus,
--
-- bind f' xs = concat (map f' xs)
-- unit x = [x] Wheere a unit of x is simply a wrapped val of x
-- 
-- I want to show that binding unit to xs will return just xs If successful
-- bind unit xs
-- = concat (map unit xs)
-- = concat (map unit [x1, x2, ..., xN])
-- = concat [unit x1, unit x2, ..., unit xN]
-- = concaat [[x1], [x2], ..., [xN]]
-- = [x1, x2, ..., xN]
-- = xs
--
--
--  Now to eval LHE
-- (f' * unit) (x: xs)
-- = ((bind f') . (bind unit)) (x:xs)
-- = bind f' (bind unit (x:xs))
-- Since bind unit (x) -> x
-- = bind f' (x:xs)
--
-- Now to eval RHE
-- (unit * f') (x: xs)
-- = ((bind unit) . (bind f')) (x: xs)
-- = bind unit (bind f' (x:xs))
-- = bind f'(x:xs)
-- same as: 
-- = bind unit (concat (map f' [x1, x2, ..., xN]))
-- = bind unit (concat [f' x1, f' x2, ...])
-- = bind unit (concat [(unit . f) x1, (unit . f) x2, ...])
-- = bind unit (concat [(unit (f x1)), (unit (f x2)), ...])
-- = bind unit (concat [[f x1], [f x2], ...])
-- = bind unit [f x1, f x2, ...]
-- = concat (map unit [f x1, f x2, ...])
-- ...
-- = [f x1, f x2, ...]
--
-- 
-- 9 Same idea as 6 but now expanding upon it.
-- Currentyly unit (or return) only applies to ordinary values but what about monadic val?
-- Way to do this is to bind return
--
-- Declartion of type var
-- f:: a -> b
-- An fmap implemented with (>>=) and return
-- liftM :: Monad m => (a->b) -> m a -> m b
-- return :: a -> m a   (half monadic)
-- (liftM f) :: m a -> m b
-- (>>=) :: Monad m => m a (a -> m b) -> m b
-- 
-- (bind return xs) -> ys
-- (bind return) applies to xs
-- return applies to x
-- Which can then be composed with liftM
-- i.e. bind liftM (bind return xs) 
-- Where the arg passed into liftM is a monadic type
--
-- Made the unit(or return) a half-monadic fnx
