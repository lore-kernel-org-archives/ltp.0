From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 27 Apr 2020 21:30:13 +0200
Subject: [LTP] [PATCH 2/4] syscalls/fanotify15: Minor corrections
In-Reply-To: <20200421065002.12417-3-amir73il@gmail.com>
References: <20200421065002.12417-1-amir73il@gmail.com>
 <20200421065002.12417-3-amir73il@gmail.com>
Message-ID: <20200427193013.GA12248@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> - Fix calculation of events buffer size
> - Read file events and dir events in two batches
> - Generate FAN_MODIFY event explicitly with truncate() operation
>   instead of FAN_ATTRIB event implicitly with create() operation
> - FAN_MODIFY and FAN_DELETE_SELF may or may not be merged

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Whole patchset LGTM, but I'd prefer Jan or somebody else reviewed it.

Kind regards,
Petr
