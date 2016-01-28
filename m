From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 28 Jan 2016 14:41:27 +0100
Subject: [LTP] [PATCH] numa_node_size: drop definition of
 numa_exit_on_error
In-Reply-To: <83f07ff547bd812f586777e944097bae0b410ca6.1453981115.git.jstancek@redhat.com>
References: <83f07ff547bd812f586777e944097bae0b410ca6.1453981115.git.jstancek@redhat.com>
Message-ID: <20160128134127.GA3101@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> numa_exit_on_error is defined by numactl library in libnuma.c,
> at least since version 0.9. Re-defining it in test can cause
> compile problems.

I've tried to rebuild LTP without the line in question on couple of SUSE
distros and it haven't caused any problems. I wonder why it wasn't
failing the compilation before though, the variable is defined right in
the libnuma.c in the library.

-- 
Cyril Hrubis
chrubis@suse.cz
