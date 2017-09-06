From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Sep 2017 13:52:52 +0200
Subject: [LTP] Test case float_trigo Reading dsin error
In-Reply-To: <0cca61a2-68a6-72e6-70af-ac437b6e0500@de.bosch.com>
References: <9b9cf670-cc80-1083-3401-c2191d227f5b@de.bosch.com>
 <20170822145003.GA26138@rei.lan>
 <0cca61a2-68a6-72e6-70af-ac437b6e0500@de.bosch.com>
Message-ID: <20170906115252.GA23579@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> what is the format of dsin and dtan files ? i.e how do they look like 
> since they are binaries i have no clue for creating them.

No idea either, you would have to look into the source code that
prepares these in trigo/gen*.c

> i just had a look at the link here
> https://github.com/linux-test-project/ltp/tree/master/testcases/misc/math/float/trigo
> 
> to be able to generate the data files "manually" , but such data files 
> shall be generated automatically when running the ./float_trigo test 
> cases itself. do you have an idea how so that happens ? and what is the 
> destination directory of the generated files , since i checked 
> /opt/ltp/testcases/bin but didn't find any data files generated there.

Looking into the source code the generators are called from main.c which
executes line composed as: ("cd %s; %s/%s %s", datadir, bin_path,
GENERATOR, bin_path) and the generators create files in $CWD and unless
there is a -D parameter passed to the test the datadir defaults to ".".
The runtest/math file does cd $LTPROOT/testcases/bin before it executes
the test so I guess that by default these files end up in the
/opt/ltp/testcases/bin/ directory. But all of that code is quite messy
so I may be as well wrong.

-- 
Cyril Hrubis
chrubis@suse.cz
