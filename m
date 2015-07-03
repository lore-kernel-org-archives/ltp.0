Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZAx75-0008Tv-3b
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2015 09:18:27 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZAx73-00036N-NA
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2015 09:18:27 +0000
Date: Fri, 3 Jul 2015 11:18:16 +0200
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <20150703091815.GA2855@dustball.brq.redhat.com>
References: <1435724565-19631-1-git-send-email-sunyuan3@huawei.com>
	<1715707849.11822659.1435846199391.JavaMail.zimbra@redhat.com>
	<5595FC03.10602@huawei.com>
	<1526251635.12159899.1435909417100.JavaMail.zimbra@redhat.com>
	<55965241.5020206@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <55965241.5020206@huawei.com>
Subject: Re: [LTP] [PATCH V2] userns01: add capability verification
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Yuan Sun <sunyuan3@huawei.com>
Cc: ltp-list@lists.sourceforge.net


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 03, 2015 at 05:13:37PM +0800, Yuan Sun wrote:
> Hi Jan,
>     The following link is unaccessible because HuaWei's network
> security strategy.
>     Could you please attach the test.c file for me?
> http://fpaste.org/239445/35909330/

Was afraid my web email client would mangle it. Attached.

Regards,
Jan


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="test.c"

#include <linux/types.h>
#include <sys/capability.h>
#include <stdio.h>

#define NUMBER_OF_CAP_SETS      3
#if defined(_LINUX_CAPABILITY_VERSION_3)
# if (_LINUX_CAPABILITY_VERSION_3 != 0x20080522)
#  error Kernel <linux/capability.h> v3 does not match library
#  error file "libcap.h" --> fix and recompile libcap
# else
#  define _LIBCAP_CAPABILITY_VERSION  _LINUX_CAPABILITY_VERSION_3
#  define _LIBCAP_CAPABILITY_U32S     _LINUX_CAPABILITY_U32S_3
# endif
#endif

struct _cap_struct {
    struct __user_cap_header_struct head;
    union {
        struct __user_cap_data_struct set;
        __u32 flat[NUMBER_OF_CAP_SETS];
    } u[_LIBCAP_CAPABILITY_U32S];
};

int main(void)
{
	
	cap_t caps, expectedcaps;
	int i;

	caps = cap_get_proc();
	expectedcaps = cap_from_text("=ep");
	
	for (i = 0; i < _LIBCAP_CAPABILITY_U32S; i++)
		printf("%08x ", caps->u[i].flat[CAP_EFFECTIVE]);
	printf("\n");

	for (i = 0; i < _LIBCAP_CAPABILITY_U32S; i++)
		printf("%08x ", expectedcaps->u[i].flat[CAP_EFFECTIVE]);
	printf("\n");

	printf("cap_compare: %d\n", cap_compare(caps, expectedcaps));

	return 0;
}

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
--jRHKVT23PllUwdXP
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--jRHKVT23PllUwdXP--

