Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O6ikd-00076h-6X
	for ltp-list@lists.sourceforge.net; Tue, 27 Apr 2010 11:14:51 +0000
Received: from mail-pv0-f174.google.com ([74.125.83.174])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O6ikc-00059F-A3
	for ltp-list@lists.sourceforge.net; Tue, 27 Apr 2010 11:14:51 +0000
Mime-Version: 1.0 (Apple Message framework v1078)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <1619776181.1046641272366183715.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Date: Tue, 27 Apr 2010 04:14:40 -0700
Message-Id: <B5EE9EDA-4C27-4791-9415-A9D9779D43EA@gmail.com>
References: <1619776181.1046641272366183715.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] UTIMENSAT test fails hugely
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
To: Caspar ZHANG <czhang@redhat.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Apr 27, 2010, at 4:03 AM, Caspar ZHANG wrote:

> 
> ----- "Garrett Cooper" <yanegomi@gmail.com> wrote:
> 
>> On Apr 27, 2010, at 2:23 AM, Caspar ZHANG wrote:
>> 
>>> <syscalls-utimensat01-run-sudo-without-tty.patch>
>> 
>> 	What good would this do if the value's deleted and not restored? It's
>> better to document this IMO because then it at least brings the issue
>> to light as there may be other areas of the tree that require this
>> kind of intervention.
> 
> I didn't realize this matter, thanks for pointing it out. So what if adding 
> the `Defaults requiretty' value back after this test finished? 

	If it's commented out (which is better than it being deleted), sure. Just be sure to do the inverse operation via trap ... EXIT ;), like:

setup
trap 'trap "" EXIT; teardown' EXIT

	You may want to execute the handler before the setup call is invoked to ensure that everything done is properly undone in the event of a failure during setup.
	Also, watch out for cases where a user may have done:

# requiretty

instead of:

requiretty

	It probably would be wise to preserve all leading and trailing characters for teardown to avoid inadvertently enabling requiretty in sudo.
	The EXIT trap handler isn't 100% foolproof, but it protects against all but SIGKILL or SIGSTOP from being executed as they're NMIs.
Cheers,
-Garrett
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
