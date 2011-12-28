Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Rfo9j-0001dj-SE
	for ltp-list@lists.sourceforge.net; Wed, 28 Dec 2011 07:42:35 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Rfo9j-0003Wb-4L
	for ltp-list@lists.sourceforge.net; Wed, 28 Dec 2011 07:42:35 +0000
Received: by iakh37 with SMTP id h37so22335356iak.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 27 Dec 2011 23:42:29 -0800 (PST)
Message-ID: <4EFABB82.7090002@casparzhang.com>
Date: Wed, 28 Dec 2011 14:47:30 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <76bf538a-270a-456b-8b7b-9c651396d76a@zmail13.collab.prod.int.phx2.redhat.com>
In-Reply-To: <76bf538a-270a-456b-8b7b-9c651396d76a@zmail13.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH v6 1/2] mem/lib: add vm tunable file
 read/write/check func
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
To: ltp-list@lists.sourceforge.net

On 11/15/2011 09:14 PM, Zhouping Liu wrote:
> hi, Cyril & Garrett
> v5 -> v6: updated the sscanf() function in read_meminfo() in order to avoid buffer overflow.
> 
> please feel free to comment the patch.
> BTW: you would miss the patch.
> 
> There are several vm tunable files under /proc/sys/vm, I will compose
> some cases for testing the basic functions of them. This patch is adding
> the read/write/check functions to mem lib so that I can include them in
> my testcases.
> 
> set_sys_tune():   set a long long integer value to a vm tunable file.
> get_sys_tune():   get a long long integer value from a vm tunable file.
> check_sys_tune(): check to confirm the value in tunable file meets our
>                   expectation.
> read_meminfo():   read the special value from /proc/meminfo.
> 
> Since most of the values in vm tunable files contain only single
> integer, the functions I added only read/write long long values for now.
> For those files not storing single interger (e.g. lowmem_reserve_ratio),
> these functions will not be used in the case.
> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>
> ---
>  runtest/mm                         |    7 +++
>  testcases/kernel/mem/include/mem.h |    7 +++
>  testcases/kernel/mem/lib/mem.c     |   84 +++++++++++++++++++++++++++++++++++-
>  3 files changed, 97 insertions(+), 1 deletions(-)

After talking to Zhouping Liu, I committed this patch with some
modifications.

Thanks,
Caspar


------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
