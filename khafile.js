let project = new Project('nanovg test');

project.addAssets('Assets/**');
project.addShaders('Shaders/**');
project.addSources('Sources');

await project.addProject('nanovg');

resolve(project);
