From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 8 Dec 2020 14:44:31 +0100
Subject: [LTP] [PATCH] net: netstat: clean and update to the new API
In-Reply-To: <20201201105739.11205-1-kory.maincent@bootlin.com>
References: <20201201105739.11205-1-kory.maincent@bootlin.com>
Message-ID: <X8+DP+HHL08/1Koc@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Kory, Alexey,


> Make it compatible with busybox
Thanks, merged!

BTW I wonder if this smoke tests is really useful somehow to detect network
problems. Not really sure if we should really keep it.
If yes, we might want to support also ss as netstat is legacy (but busybox
supports only netstat).

Kind regards,
Petr
