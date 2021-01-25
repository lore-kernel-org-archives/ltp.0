From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 25 Jan 2021 09:29:19 +0100
Subject: [LTP] [PATCH RFC 1/2] lib: add SAFE_READ_PROC_STATUS macro
In-Reply-To: <20210125064747.26759-1-liwang@redhat.com>
References: <20210125064747.26759-1-liwang@redhat.com>
Message-ID: <YA6BXytZalu41DlP@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> To parse /proc/PID/status files, for example:
>     SAFE_READ_PROC_STATUS(pid, "VmSwap:");

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
