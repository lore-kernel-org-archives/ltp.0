From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Jan 2017 16:49:58 +0100
Subject: [LTP] [PATCH v2 1/1] travis: initial configuration
In-Reply-To: <20170111125937.19842-1-petr.vorel@gmail.com>
References: <20170111125937.19842-1-petr.vorel@gmail.com>
Message-ID: <20170111154957.GA10729@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I did some tests with email notifications and figured out that anything
else than having the mailing list address hardcoded in the travis config
is pretty much useless since neither the commited nor the patch author
gets email unless they are registered in travis.

So I will commit the V1 patch that has the mailing list address in the
config to see if that is a workable solution. Hopefully that will not
spam the mailing list too much.

-- 
Cyril Hrubis
chrubis@suse.cz
