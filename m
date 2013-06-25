Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sedat.dilek@gmail.com>) id 1UrU4W-0004lB-Cu
	for ltp-list@lists.sourceforge.net; Tue, 25 Jun 2013 14:18:16 +0000
Received: from mail-wg0-f53.google.com ([74.125.82.53])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UrU4V-0006NB-HP
	for ltp-list@lists.sourceforge.net; Tue, 25 Jun 2013 14:18:16 +0000
Received: by mail-wg0-f53.google.com with SMTP id y10so9352820wgg.8
	for <ltp-list@lists.sourceforge.net>;
	Tue, 25 Jun 2013 07:18:09 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 25 Jun 2013 16:18:09 +0200
Message-ID: <CA+icZUXjY1QAWk80FqnENt=S1H+x+MaREjoHMuOmoq-QMnT3+A@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: [LTP] [ltp-full-20130503] runltp and dash-bug
Reply-To: sedat.dilek@gmail.com
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

Hi,

just an info to all Debian/Ubuntu users who want to use the latest
official LTP-full release (03-May-2013) as DASH is the default shell.
Again, we have some BASHISM to kill.
You need the fix from ltp master GIT [1].

commit b88fa5b6ec5a29834a0e52df7b22b9bb47fe0379
"runltp: Fix bashism"

Discovered when trying to run the IPC test-suite on Ubuntu/precise:

     root# ./runltp -f ipc

Hope this helps by warning.

Regards,
- Sedat -

[1] https://github.com/linux-test-project/ltp/commit/b88fa5b6ec5a29834a0e52df7b22b9bb47fe0379

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
