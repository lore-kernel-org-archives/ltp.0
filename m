From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 28 Jan 2016 09:45:45 -0500 (EST)
Subject: [LTP] [PATCH] numa_node_size: drop definition of
 numa_exit_on_error
In-Reply-To: <20160128134127.GA3101@rei>
References: <83f07ff547bd812f586777e944097bae0b410ca6.1453981115.git.jstancek@redhat.com>
 <20160128134127.GA3101@rei>
Message-ID: <952947167.13501619.1453992345342.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Thursday, 28 January, 2016 2:41:27 PM
> Subject: Re: [LTP] [PATCH] numa_node_size: drop definition of numa_exit_on_error
> 
> Hi!
> > numa_exit_on_error is defined by numactl library in libnuma.c,
> > at least since version 0.9. Re-defining it in test can cause
> > compile problems.
> 
> I've tried to rebuild LTP without the line in question on couple of SUSE
> distros and it haven't caused any problems. I wonder why it wasn't
> failing the compilation before though, the variable is defined right in
> the libnuma.c in the library.

Linker doesn't seem to mind when linking against shared library.
His build had --static, so I'm guessing noone has tried (and reported) that before.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
