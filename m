From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 5 Nov 2020 17:29:49 +0100
Subject: [LTP] [PATCH v2] Convert dup02 to new API and clean up
In-Reply-To: <20201105085045.31247-1-radoslav.kolev@suse.com>
References: <20201105085045.31247-1-radoslav.kolev@suse.com>
Message-ID: <20201105162949.GA12378@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Radoslav,

merged with tiny change: use TTERRNO instead of TERRNO
(because we are calling TEST() macro).

Kind regards,
Petr
