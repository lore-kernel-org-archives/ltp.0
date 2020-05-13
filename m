From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 May 2020 11:31:36 +0200
Subject: [LTP] [PATCH v2] pty04: Retry reads when short
In-Reply-To: <20200513090453.6071-1-rpalethorpe@suse.com>
References: <20200513090453.6071-1-rpalethorpe@suse.com>
Message-ID: <20200513093136.GC4598@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

> Even though reads are blocking and packets are flipped into the netdevice
> buffer whole, it seems read may return before a full packet is read into user
> land. Retrying read should prevent timeouts and read failures on some
> machines.
I'm still able to block the test after some loops:
pty04.c:328: PASS: Read netdev 1
(using 5.7.0-rc4 from openSUSE Tumbleweed).

Kind regards,
Petr
