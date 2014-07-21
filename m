Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1X99cX-0007IQ-8H
	for ltp-list@lists.sourceforge.net; Mon, 21 Jul 2014 09:10:57 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X99cV-00088l-US
	for ltp-list@lists.sourceforge.net; Mon, 21 Jul 2014 09:10:57 +0000
Message-ID: <53CCD8DB.7030703@cn.fujitsu.com>
Date: Mon, 21 Jul 2014 17:09:47 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1405419229-4222-1-git-send-email-wangxg.fnst@cn.fujitsu.com>	<1405419229-4222-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<38788431.12648558.1405933467675.JavaMail.zimbra@redhat.com>
In-Reply-To: <38788431.12648558.1405933467675.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH 2/2] syscalls/getcwd04.c: regression test for
	getcwd(2)
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Jan Stancek <jstancek@redhat.com>, Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net, Artem Savkov <asavkov@redhat.com>

On 07/21/2014 05:04 PM, Jan Stancek wrote:
> 
> 
> ----- Original Message -----
>> > From: "Xiaoguang Wang" <wangxg.fnst@cn.fujitsu.com>
>> > To: ltp-list@lists.sourceforge.net
>> > Sent: Tuesday, 15 July, 2014 12:13:49 PM
>> > Subject: [LTP] [PATCH 2/2] syscalls/getcwd04.c: regression test for getcwd(2)
>> > 
>> > Note: this test has already been in xfstests generic/028 test case,
>> > I just port it to LTP.
>> > 
>> > Kernel commit '232d2d60aa5469bb097f55728f65146bd49c1d25' introduced a race
>> > condition that causes getcwd(2) to return "/" instead of correct path.
>> >     232d2d6 dcache: Translating dentry into pathname without
>> >             taking rename_lock
>> > 
>> > And these two kernel commits have fixed this bug:
>> >   ede4cebce16f5643c61aedd6d88d9070a1d23a68
>> >      prepend_path() needs to reinitialize dentry/vfsmount/mnt on restarts
>> >   f6500801522c61782d4990fa1ad96154cb397cd4
>> >      f650080 __dentry_path() fixes
>> > 
>> > This test is to check whether this bug exists in the running kernel,
>> > or whether this bug has been fixed.
>> > 
>> > Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> Hi,
> 
> looks good to me.
> 
>> > I have run this test case in RHEL7.0GA, Fedora19, v3.11-7758-g232d2d6 and 3.16.0-rc4+.
>> > RHEL7.0GA has this kernel bug, so this test case fails.
> I can confirm this, with note that I've seen it happen only on systems with 2+ CPUs.

If this note is truth, we should judge the nr_cpus in this case to make sure it always
gives the right result.

Thanks,
Wanlong Gao
 


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
