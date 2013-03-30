//
//  Shader.fsh
//  blah
//
//  Created by Mark Mevorah on 3/27/13.
//  Copyright (c) 2013 Mark Mevorah. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
