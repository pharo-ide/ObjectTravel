baselines
baseline: spec
	<baseline>
	spec for: #'common' do: [
		spec baseline: 'StateSpecs' with: [
			spec repository: 'github://dionisiydk/StateSpecs:v2.4.10' ].
		spec 
			package: 'ObjectTravel';
			package: 'ObjectTravel-Tests' with: [spec requires: #(StateSpecs ObjectTravel)].
		spec 
			group: 'default' with: #('Core' 'Tests');
			group: 'Core' with: #('ObjectTravel');
			group: 'Tests' with: #('ObjectTravel-Tests') ].
