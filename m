From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 14 Jun 2021 16:44:04 +0200
Subject: [LTP] [PATCH v3] setitimer02: Convert setitimer02 to new API
In-Reply-To: <20210613173043.8797-1-vinay.m.engg@gmail.com>
References: <YMNrt8TxrxhNjFPN@yuki>
 <20210613173043.8797-1-vinay.m.engg@gmail.com>
Message-ID: <YMdrNLcYKCK7aK4d@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with small changes, thanks.

* Slightly adjusted the docparse comment

* Switched from malloc to .bufs static declaration in test structure

-- 
Cyril Hrubis
chrubis@suse.cz
