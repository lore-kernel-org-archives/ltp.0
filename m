From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Jan 2021 15:29:35 +0100
Subject: [LTP] [PATCH v3 5/7] can_recv_own_msgs: Convert to new library
In-Reply-To: <20210120143723.26483-6-rpalethorpe@suse.com>
References: <20210120143723.26483-1-rpalethorpe@suse.com>
 <20210120143723.26483-6-rpalethorpe@suse.com>
Message-ID: <YA7Vz6IanQ7fMgEQ@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -struct rxs test_sockets(int s, int t, canid_t can_id)
> +void test_sockets(canid_t can_id, int expect_rxs, int expect_rxt)

static?

However this is very minor.

-- 
Cyril Hrubis
chrubis@suse.cz
