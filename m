Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1X99yS-0000wu-OK
	for ltp-list@lists.sourceforge.net; Mon, 21 Jul 2014 09:33:36 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X99yQ-0006Lc-R3
	for ltp-list@lists.sourceforge.net; Mon, 21 Jul 2014 09:33:36 +0000
Date: Mon, 21 Jul 2014 05:33:06 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1654492351.12657216.1405935186511.JavaMail.zimbra@redhat.com>
In-Reply-To: <53CCD8DB.7030703@cn.fujitsu.com>
References: <1405419229-4222-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1405419229-4222-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<38788431.12648558.1405933467675.JavaMail.zimbra@redhat.com>
	<53CCD8DB.7030703@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 2/2] syscalls/getcwd04.c: regression test for
 getcwd(2)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: gaowanlong@cn.fujitsu.com
Cc: Artem Savkov <asavkov@redhat.com>, ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> To: "Jan Stancek" <jstancek@redhat.com>, "Xiaoguang Wang" <wangxg.fnst@cn.fujitsu.com>
> Cc: ltp-list@lists.sourceforge.net, "Artem Savkov" <asavkov@redhat.com>
> Sent: Monday, 21 July, 2014 11:09:47 AM
> Subject: Re: [LTP] [PATCH 2/2] syscalls/getcwd04.c: regression test for getcwd(2)
> 
> On 07/21/2014 05:04 PM, Jan Stancek wrote:
> > 
> > 
> > ----- Original Message -----
> >> > From: "Xiaoguang Wang" <wangxg.fnst@cn.fujitsu.com>
> >> > To: ltp-list@lists.sourceforge.net
> >> > Sent: Tuesday, 15 July, 2014 12:13:49 PM
> >> > Subject: [LTP] [PATCH 2/2] syscalls/getcwd04.c: regression test for
> >> > getcwd(2)
> >> > 
> >> > Note: this test has already been in xfstests generic/028 test case,
> >> > I just port it to LTP.
> >> > 
> >> > Kernel commit '232d2d60aa5469bb097f55728f65146bd49c1d25' introduced a
> >> > race
> >> > condition that causes getcwd(2) to return "/" instead of correct path.
> >> >     232d2d6 dcache: Translating dentry into pathname without
> >> >             taking rename_lock
> >> > 
> >> > And these two kernel commits have fixed this bug:
> >> >   ede4cebce16f5643c61aedd6d88d9070a1d23a68
> >> >      prepend_path() needs to reinitialize dentry/vfsmount/mnt on
> >> >      restarts
> >> >   f6500801522c61782d4990fa1ad96154cb397cd4
> >> >      f650080 __dentry_path() fixes
> >> > 
> >> > This test is to check whether this bug exists in the running kernel,
> >> > or whether this bug has been fixed.
> >> > 
> >> > Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> > Hi,
> > 
> > looks good to me.
> > 
> >> > I have run this test case in RHEL7.0GA, Fedora19, v3.11-7758-g232d2d6
> >> > and 3.16.0-rc4+.
> >> > RHEL7.0GA has this kernel bug, so this test case fails.
> > I can confirm this, with note that I've seen it happen only on systems with
> > 2+ CPUs.
> 
> If this note is truth, we should judge the nr_cpus in this case to make sure
> it always
> gives the right result.

My observation is that it's at least easier to reproduce on 2+ CPUs:

# time taskset -c 0 ./getcwd04 
getcwd04    1  TPASS  :  Bug is not reproduced!

real	0m5.002s
user	0m0.506s
sys	0m4.494s

# time taskset -c 0,1 ./getcwd04 
getcwd04    1  TFAIL  :  initial current work directory is /tmp/getg6foNN/testdir, now is /. Bug is reproduced!

real	0m0.002s
user	0m0.000s
sys	0m0.002s


I'm not sure what you are suggesting we do, other than to make note somewhere.

It's a test for race condition, so if it tried its best to reproduce and
ended with "Bug is not reproduced!", that looks like right result to me.

Regards,
Jan

> 
> Thanks,
> Wanlong Gao
>  
> 
> 

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
