Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wd0f6-0001Or-W0
	for ltp-list@lists.sourceforge.net; Wed, 23 Apr 2014 17:08:45 +0000
Date: Wed, 23 Apr 2014 19:07:53 +0200
From: chrubis@suse.cz
Message-ID: <20140423170753.GG16286@rei.suse.cz>
References: <1397211402-12361-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1397211402-12361-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 1/2] lib/tst_fs_has_free.c: add
 tst_fs_has_free() to determine filesystem's free space
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +int tst_fs_has_free(void (*cleanup)(void), const char *path,
> +	uint64_t required_kib);

And I'm thinking if it would be better to change the interface to get
size and multiplier something as:

enum {
	TST_KB = 1024,
	TST_MB = 1048576,
	TST_GB = 1073741824,
};

int tst_fs_has_free(void (*cleanup)(void), const char *path,
                    unsigned int size, unsigned int mult);

And the use it as:

tst_fs_has_free(cleanup, ".", 10, TST_MB);

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
