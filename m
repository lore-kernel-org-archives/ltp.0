From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 May 2018 12:56:21 +0200
Subject: [LTP] [PATCH] fs/read_all: Clear suplementary groups before
 droping privileges
In-Reply-To: <87603g9ebe.fsf@rpws.prws.suse.cz>
References: <20180518170933.GA5094@rei>
 <1526721740-8382-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <87603g9ebe.fsf@rpws.prws.suse.cz>
Message-ID: <20180522105621.GC27975@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> LGTM!

We may as well think about safe groups for the program, looking at my
/dev/ it may sense to add auxiliary groups disk and tty so that we tests
these devices as well.

-- 
Cyril Hrubis
chrubis@suse.cz
