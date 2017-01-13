From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 13 Jan 2017 14:15:44 +0300
Subject: [LTP] [PATCH 1/1] network: remove unnecessary check for rsh in
 scripts
In-Reply-To: <20161219132416.26987-1-pvorel@suse.cz>
References: <20161219132416.26987-1-pvorel@suse.cz>
Message-ID: <5878B6E0.9060801@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 19.12.2016 16:24, Petr Vorel wrote:
> scripts rlogin01 and telnet01 don't use rsh directly, but via
> tst_rhost_run. This means that ssh or netns can be used instead of rsh.

Applied, thanks!

Best regards,
Alexey

