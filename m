From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 14 Jun 2021 16:19:51 +0200
Subject: [LTP] [PATCH v3] getitimer02: Convert getitimer02 to new API
In-Reply-To: <20210613164335.6035-1-vinay.m.engg@gmail.com>
References: <YMNoFyN89L6/VhP3@yuki>
 <20210613164335.6035-1-vinay.m.engg@gmail.com>
Message-ID: <YMdlh1Ek/jknzjq9@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with small changes, thanks.

* Adjusted the docparse comment to be more clear

* I've removed the printf format from TST_EXP_FAIL() since
  in this case the automatic message will be nicer

-- 
Cyril Hrubis
chrubis@suse.cz
