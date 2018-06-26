From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 26 Jun 2018 07:22:53 -0400 (EDT)
Subject: [LTP] [PATCH] cve/meltdown: read *saved_command_line
In-Reply-To: <20180626093850.GE24288@rei>
References: <761d2d176c0765f3913e140191ceaf83aa745424.1529495077.git.jstancek@redhat.com>
 <20180626093850.GE24288@rei>
Message-ID: <1799109822.29007031.1530012173372.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> Looking at kernel git the saved_command_line is allocated dynamically
> since 2.6.21 which I guess is old enough but we may as well mention this
> in the commit message:
> 
> commit 30d7e0d466b3ac0b5ef77e4062bf9385f0d72270
> Author: Alon Bar-Lev <alon.barlev@gmail.com>
> Date:   Mon Feb 12 00:53:52 2007 -0800
> 
>     [PATCH] Dynamic kernel command-line: common

I added this to commit message. It should be old enough,
we run the test on kernels older than 2.6.32 anyway.

> Other than that it looks good, acked.

Thanks, pushed.
Jan
