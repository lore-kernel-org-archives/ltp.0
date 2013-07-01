Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1UtZW7-0005sI-SU
	for ltp-list@lists.sourceforge.net; Mon, 01 Jul 2013 08:31:23 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UtZW3-0006tr-Sq
	for ltp-list@lists.sourceforge.net; Mon, 01 Jul 2013 08:31:23 +0000
Message-ID: <51D13E38.5010309@oracle.com>
Date: Mon, 01 Jul 2013 12:30:48 +0400
From: alexey.kodanev@oracle.com
MIME-Version: 1.0
References: <1372345762-5425-1-git-send-email-alexey.kodanev@oracle.com>
	<201306280135.45066.vapier@gentoo.org>
In-Reply-To: <201306280135.45066.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v4] lib: tst_module: add library functions for
 kernel modules
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net


On 06/28/2013 09:35 AM, Mike Frysinger wrote:
> On Thursday 27 June 2013 11:09:22 Alexey Kodanev wrote:
> \>  +void tst_module_load(void (cleanup_fn)(void),
>> +	const char *mod_name, char *const argv[])
>> +{
>> +	char *mod_path = NULL;
>> +	tst_module_exists(cleanup_fn, mod_name,&mod_path);
>> +
>> +	static int offset = 2; /* command name&  module path */
> why static ?  i would use const instead.
> -mike
Yes, const must be used here, and static is not needed for an int. I 
will fix it.

Thanks,
Alexey

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
