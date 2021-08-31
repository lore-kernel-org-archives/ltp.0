From: Li Wang <liwang@redhat.com>
Date: Tue, 31 Aug 2021 21:24:51 +0800
Subject: [LTP] [PATCH 1/2] cfs_bandwidth01: Fix cleanup on failure in
 set_cpu_quota
In-Reply-To: <2278cad7-66ab-d014-ca2b-ab3081f1284d@jv-coder.de>
References: <20210831090002.1431298-1-lkml@jv-coder.de>
 <87eeaakm4y.fsf@suse.de>
 <2278cad7-66ab-d014-ca2b-ab3081f1284d@jv-coder.de>
Message-ID: <CAEemH2cSKUz63b_607Zs0_5q3RNb5-muh_jQa+2EBbTBEHsVww@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg, Richard,



> >> -static struct tst_cgroup_group *
> >> -mk_cpu_cgroup(const struct tst_cgroup_group *const cg_parent,
> >> +static void mk_cpu_cgroup(struct tst_cgroup_group **cg,
> >> +          const struct tst_cgroup_group *const cg_parent,
> > Seems like there are spaces instead of a tab at the start.
>


> Right, I wanted to keep the same format you had, but did not realize it
> was one tab and 5 spaces instead of 9 spaces.
> I guess this can be fixed during merging.
>

I fixed that and pushed those patches. Thanks!

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210831/33d6120f/attachment-0001.htm>
