From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 10 Jan 2018 15:05:21 +0100
Subject: [LTP] [PATCH] Remove pthread_barrier_wait_6-1 because it is
 unreliable
In-Reply-To: <20180110115941.6715-1-rpalethorpe@suse.com>
References: <20180110115941.6715-1-rpalethorpe@suse.com>
Message-ID: <20180110140521.GA3746@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
[CCing Jan]

Jan can you please have a look to see if this can go in before the
release? The test started to fail on newer glibc (due to changes in
barrier implementation it ends up either with abort() of floating point
exception) and it's IMHO broken by desing as Ritchard described.

-- 
Cyril Hrubis
chrubis@suse.cz
