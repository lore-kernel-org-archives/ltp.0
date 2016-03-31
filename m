From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 31 Mar 2016 14:07:26 +0200
Subject: [LTP] [PATCH] max_map_count: fix error by using runtime check
In-Reply-To: <1242994016.13404335.1458728559657.JavaMail.zimbra@redhat.com>
References: <56DD6138.9060109@huawei.com> <20160322102943.GA10195@rei.suse.cz>
 <56F14D59.1040701@huawei.com> <20160322142842.GE10905@rei.suse.cz>
 <56F259A7.1080908@huawei.com>
 <1242994016.13404335.1458728559657.JavaMail.zimbra@redhat.com>
Message-ID: <20160331120726.GB21298@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Can we relax the pass condition to allow map_count to be
> within some tolerance? Then we wouldn't have to worry so much about
> all arch specifics.

Looking at the code we skip exactly one mapping on some architectures.
So it looks like allowing the number of mappings to be greater by one
uncoditionally should solve the problem.

But I'm still undecided if we should go this way as we will weaken the
test assertion since at the moment we skip exact mappings by their
label.

-- 
Cyril Hrubis
chrubis@suse.cz
