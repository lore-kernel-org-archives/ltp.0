From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 11 Apr 2016 19:03:59 +0200
Subject: [LTP] [PATCH] max_map_count: fix error by using runtime check
In-Reply-To: <5703A5C6.3000102@huawei.com>
References: <56DD6138.9060109@huawei.com> <20160322102943.GA10195@rei.suse.cz>
 <56F14D59.1040701@huawei.com> <20160322142842.GE10905@rei.suse.cz>
 <56F259A7.1080908@huawei.com>
 <1242994016.13404335.1458728559657.JavaMail.zimbra@redhat.com>
 <20160331120726.GB21298@rei.lan> <5703A5C6.3000102@huawei.com>
Message-ID: <20160411170358.GB3466@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> 2. Now we only find the problem in aarch64, we just fix it:
> 
> #elif defined(__arm__)
> 	/* Skip it when run it in aarch64 */
> 	if(strcmp(un.machine, "aarch64"))
> 		return false;
> 
> 	/* Older arm kernels didn't label their vdso maps */
> 	if (!strncmp(line, "ffff0000-ffff1000", 17))
> 		return true;
> 
> And I think the second is better :-D

Let's go with this one for now and if we find more special cases later
we can relax the conditions as Jan suggested.

-- 
Cyril Hrubis
chrubis@suse.cz
