From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 26 Apr 2017 17:06:41 +0200
Subject: [LTP] [RFC] [PATCH] tst_kvcmp: Add support for extra kernel
	versions
In-Reply-To: <343130515.905228.1493020687050.JavaMail.zimbra@redhat.com>
References: <20170421155244.29773-1-chrubis@suse.cz>
 <343130515.905228.1493020687050.JavaMail.zimbra@redhat.com>
Message-ID: <20170426150641.GA6165@rei.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Jan can you please check that everything works fine when specifying extra
> > version on RHEL? It seems that the only systems that are supported by extra
> > kernel versions are RHEL5 and RHEL6 at the moment.
> 
> Should we print an error also if invalid distro is passed as parameter?

That would need a table of known distros stored into the tst_kvercmp.c
and function to validate a distribution name, or do I miss something?

I guess that we can rewrite the code so that the kernel version
substring and distro name are stored in an array of structures and loop
over it so that we can say if it's valid or not but I'm not sure that
it's worth the work.

-- 
Cyril Hrubis
chrubis@suse.cz
