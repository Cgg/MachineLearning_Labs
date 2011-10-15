function walkshow(states)
  [dummy, n] = size(states);

  im = {imread('/info/mi10/labs/rl/step1.png'),
	imread('/info/mi10/labs/rl/step2.png'),
	imread('/info/mi10/labs/rl/step3.png'),
	imread('/info/mi10/labs/rl/step4.png'),
	imread('/info/mi10/labs/rl/step5.png'),
	imread('/info/mi10/labs/rl/step6.png'),
	imread('/info/mi10/labs/rl/step7.png'),
	imread('/info/mi10/labs/rl/step8.png'),
	imread('/info/mi10/labs/rl/step9.png'),
	imread('/info/mi10/labs/rl/step10.png'),
	imread('/info/mi10/labs/rl/step11.png'),
	imread('/info/mi10/labs/rl/step12.png'),
	imread('/info/mi10/labs/rl/step13.png'),
	imread('/info/mi10/labs/rl/step14.png'),
	imread('/info/mi10/labs/rl/step15.png'),
	imread('/info/mi10/labs/rl/step16.png')};

  p = im{states(1)};
  for i = 2:n
    p = [p, im{states(i)}];
  end

  p=p-min(p(:)); % shift data such that the smallest element of p is 0
  p=p/max(p(:)); % normalize the shifted data to 1

  imwrite(p,'cartoon.png', 'BitDepth', 16);

end
