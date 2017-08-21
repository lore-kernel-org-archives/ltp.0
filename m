From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 21 Aug 2017 08:12:27 -0400 (EDT)
Subject: [LTP] [PATCH 1/1] ltp-pan: Log start of test in kernel log
In-Reply-To: <20170821090652.17634-1-pvorel@suse.cz>
References: <20170821090652.17634-1-pvorel@suse.cz>
Message-ID: <1495369773.970106.1503317547451.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Petr Vorel" <pvorel@suse.cz>
> To: ltp@lists.linux.it
> Sent: Monday, 21 August, 2017 11:06:52 AM
> Subject: [LTP] [PATCH 1/1] ltp-pan: Log start of test in kernel log
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> I know ltp-pan is deprecated, but add kernel stamping can be useful for
> debugging.

+1, it proved to be useful. It has also been mentioned couple weeks ago here:
  https://lists.linux.it/pipermail/ltp/2017-June/004893.html

As I recall Cyril suggested an option to enable/disable this output,
but I wouldn't mind if it was always-on.

Regards,
Jan
