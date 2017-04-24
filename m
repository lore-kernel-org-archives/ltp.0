From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 24 Apr 2017 03:58:07 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] tst_kvcmp: Add support for extra kernel
	versions
In-Reply-To: <20170421155244.29773-1-chrubis@suse.cz>
References: <20170421155244.29773-1-chrubis@suse.cz>
Message-ID: <343130515.905228.1493020687050.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> This adds support for extra kernel versions to the tst_kvcmp shell
> helper.
> 
> Now we can append the extra version(s) after the generic kernel version
> in the expression. For example to check for older kernel than
> 3.0 or in case of RHEL6 older than 2.6.32 we do:
> 
> tst_kvcmp -lt '3.0 RHEL6:2.6.32'
> 
> This commit also reduces the number of uname() syscalls needed to
> acquire the result as a side efect.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Jan Stancek <jstancek@redhat.com>
> ---
> 
> Jan can you please check that everything works fine when specifying extra
> version on RHEL? It seems that the only systems that are supported by extra
> kernel versions are RHEL5 and RHEL6 at the moment.

Should we print an error also if invalid distro is passed as parameter?
I'd add 4th number to all examples: "RHEL6:2.6.32" -> "RHEL6:2.6.32-77",
because all RHEL6 kernels are 2.6.32.

# uname -r
2.6.32-71.el6.x86_64
# ./tst_kvcmp -lt '3.11 RHEL6:2.6.32'; echo $?
1
# ./tst_kvcmp -lt '3.11 RHEL6:2.6.32-77'; echo $?
0

Otherwise it looks good to me.

Regards,
Jan
