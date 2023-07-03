function varargout = zoomginput(varargin)
% zoomginput activates ginput and allows zooming in/out of the active axis
% using the mouse wheel.
% scroll up to zoom in, scroll down to zoom out.
% all other functionality is identical to ginput.
%
% Author: TADA 2019
    #scrollListener = addlistener(gcf(), 'windowscrollwheelfcn', @onScroll);
    set(gcf(), 'windowscrollwheelfcn', @onScroll);

    try
        varargout = cell(1, max(nargout, 1));
        [varargout{:}] = ginput(varargin{:});
        #delete(scrollListener);
        set(gcf(), 'windowscrollwheelfcn', [])
    catch ex
        #delete(scrollListener);
        set(gcf(), 'windowscrollwheelfcn', [])
        ex.rethrow();
    end
end

function onScroll(src, edata)
    % calculate zoom factor
    defaultFactor = 1.1;
    % factor = (defaultFactor * abs(edata.VerticalScrollCount))^sign(edata.VerticalScrollCount);
    if sign(edata.VerticalScrollCount),
      factor = 1.1;
    else
      factor = .9;
    endif

    disp(factor)

    zoomCursor(gca(), factor);
end
