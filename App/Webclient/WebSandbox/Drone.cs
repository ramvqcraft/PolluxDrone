using Godot;

public partial class Drone : Node3D
{	
	//----drone----
	private Node3D RearBody,ForeBody,MidBody;
	private Node3D Aka_Left,Aka_Right;
	private int ActiveJoint = 1;
	
	//----camera----
	private Camera3D Camera1,Camera2;
	private int ActiveCamera = -999;
	
	//----kinetics---
	private float TranslationSpeed = 0.05f;
	private float RotationSpeed = 90f;
	
	//-------------------FUNCTIONS----------------------
	public override void _Ready()
	{
		GD.Print("Drone is ready!");
		
		// Get child nodes by name		
		Aka_Left = GetNode<Node3D>("Aka_Left");
 		Aka_Right = GetNode<Node3D>("Aka_Right");
		Camera1 = GetNode<Camera3D>("Camera3D_Fixed1");
		Camera2 = GetNode<Camera3D>("Camera3D_Fixed2");

	}

	public override void _Process(double delta)
	{
		Vector3 direction = Vector3.Zero;

		//Camera selection input
		if (Input.IsActionPressed("ui_f1")){
			ActiveCamera=1;
			GD.Print("Camera one selected");			
		}

		if (Input.IsActionPressed("ui_f2")){
			ActiveCamera=2;
			GD.Print("Camera two selected");
		}
			
		//Joint switch
		if (Input.IsActionPressed("ui_number_one")){
			ActiveJoint=1;
			GD.Print("Joint one selected");
		}
			
		if (Input.IsActionPressed("ui_number_two")){
			ActiveJoint=2;
			GD.Print("Joint two selected!");
		}
						
		//
		if (Input.IsActionPressed("ui_right")){
					
			if(ActiveJoint==1)
				Aka_Left.RotateZ(Mathf.DegToRad(-RotationSpeed) * (float)delta);
				Aka_Right.RotateZ(Mathf.DegToRad(RotationSpeed) * (float)delta);

		}
			
		if (Input.IsActionPressed("ui_left")){
			
			if(ActiveJoint==1)
				Aka_Left.RotateZ(Mathf.DegToRad(RotationSpeed) * (float)delta);
				Aka_Right.RotateZ(Mathf.DegToRad(-RotationSpeed) * (float)delta);
		}
		
		if (Input.IsActionPressed("ui_up")){
		}
			
		if (Input.IsActionPressed("ui_down")){
			
		}
		
		
		//Camera switch
		if(ActiveCamera==1)
			Camera1.MakeCurrent();
		else if(ActiveCamera==2)
			Camera2.MakeCurrent();
				
		// Normalize so diagonal movement isnt faster
		if (direction != Vector3.Zero)
			direction = direction.Normalized();

		// Apply translation movement
		Position += direction * TranslationSpeed * (float)delta;
	}

}
