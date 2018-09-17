From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 17 Sep 2018 10:44:53 +0200
Subject: [LTP] LTP master: arm64 : fsetxattr02.c:214:
 open(mntpoint/fsetxattr02blk, 0, 00) failed: ENXIO
In-Reply-To: <CADtBP2DrGG8743zKzi0_SJQLSJrG27NgiOeHHvWga=RzcYPjTQ@mail.gmail.com>
References: <CA+G9fYtAuGixa5x6kgmBOa7bDkhkz6rQMY5AdBgXLjp8uZKHzg@mail.gmail.com>
 <CADtBP2DrGG8743zKzi0_SJQLSJrG27NgiOeHHvWga=RzcYPjTQ@mail.gmail.com>
Message-ID: <20180917084453.GB7857@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Not sure if there is a way, using LTP API, to enforce a module
> existing/being loaded, but BROK is definitely the correct error in this
> condition.

There is an in-flight patch set from Alexey see:

[PATCH v3 1/2] lib/tst_test.c: add 'needs_drivers' option with tst_check_drivers cmd

-- 
Cyril Hrubis
chrubis@suse.cz
