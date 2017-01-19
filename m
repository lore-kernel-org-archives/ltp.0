From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 19 Jan 2017 20:30:33 +0300
Subject: [LTP] [PATCH v2 1/1] network/mc_cmds: fix testing with iproute2
 <= ss161212
In-Reply-To: <20170118140056.15507-1-pvorel@suse.cz>
References: <20170118140056.15507-1-pvorel@suse.cz>
Message-ID: <f2512f5f-ea85-0ab1-00db-073bb2097078@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On 01/18/2017 05:00 PM, Petr Vorel wrote:
> Workaround for an upstream bug in ip:
> https://bugzilla.kernel.org/show_bug.cgi?id=192741
Applied, also added TWARN flag to tst_resm and reverted the change
with the missing white-space (in subsequent patch removed that section).

Thanks,
Alexey

