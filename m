From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 May 2018 14:04:28 +0200
Subject: [LTP] [PATCH 1/1] net/sctp: Fix parsing input variables in dash
In-Reply-To: <20180515094053.18355-1-pvorel@suse.cz>
References: <20180515094053.18355-1-pvorel@suse.cz>
Message-ID: <20180515120428.GE7220@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Dash (and maybe some other posix shells) cannot handle unquoted $@.
> It needs to be quoted when calling otherwise leads to error:
> /opt/ltp/testcases/bin/sctp01.sh: 40: local: 65000: bad variable name

It looks like this patch is working around the real problem.

Looking into bash and dash manual pages the syntax for local builtin is
slightly differente between these two.

The dash contains:

local [variable | -] ...

While bash has:

local [option] [name[=value] ... | - ]


So it looks to me like the portable way how to declare local variables is:

function()
{
	local var_name

	var_name=$foo

	...
}


And it also seems to be mentioned in one of the dash porting guides:

http://mywiki.wooledge.org/Bashism

See the builtins paragraph there.

-- 
Cyril Hrubis
chrubis@suse.cz
