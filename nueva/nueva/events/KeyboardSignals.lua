module ('KeyboardSignals', package.seeall)

--CRIAR AQUI TODOS OS SINAIS NECESSARIOS		

local signal = require("nueva/utils/signal");

-- ==========================================PRESS
addPress = signal.new();
addPressLast = signal.new();


addPressLeft = signal.new();
addPressRight = signal.new();
addPressDown = signal.new();
addPressUp = signal.new();

addPressGreen = signal.new();
addPressRed = signal.new();
addPressBlue = signal.new();
addPressYellow = signal.new();

addPressEnter = signal.new();

addPress0 = signal.new();
addPress1 = signal.new();
addPress2 = signal.new();
addPress3 = signal.new();
addPress4 = signal.new();
addPress5 = signal.new();
addPress6 = signal.new();
addPress7 = signal.new();
addPress8 = signal.new();
addPress9 = signal.new();


-- ==========================================RELEASE
addRelease = signal.new();
addReleaseLast = signal.new();

addReleaseLeft = signal.new();
addReleaseRight = signal.new();
addReleaseDown = signal.new();
addReleaseUp = signal.new();

addReleaseGreen = signal.new();
addReleaseRed = signal.new();
addReleaseBlue = signal.new();
addReleaseYellow = signal.new();

addReleaseEnter = signal.new();

addRelease0 = signal.new();
addRelease1 = signal.new();
addRelease2 = signal.new();
addRelease3 = signal.new();
addRelease4 = signal.new();
addRelease5 = signal.new();
addRelease6 = signal.new();
addRelease7 = signal.new();
addRelease8 = signal.new();
addRelease9 = signal.new();

dofile ("nueva/events/KeyboardEvent.lua")