function [projectr, projectc] = ImageProject(bw)
projectr = sum(bw, 2);
projectc = sum(bw, 1); 
