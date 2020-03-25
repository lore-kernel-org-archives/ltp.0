From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Wed, 25 Mar 2020 19:35:07 +0800
Subject: [LTP] ltp_tpci.c: fix a null pointer
In-Reply-To: <20200325113507.22086-1-po-hsu.lin@canonical.com>
References: <20200325113507.22086-1-po-hsu.lin@canonical.com>
Message-ID: <20200325113507.22086-2-po-hsu.lin@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We have encountered this null pointer dereference issue too, with this
fix the test can be executed properly.

Tested-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
