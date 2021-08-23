From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 23 Aug 2021 06:31:43 +0200
Subject: [LTP] [PATCH v2 2/2] pec: Improve reliability
In-Reply-To: <YR+Lc8aBnK6KBOnW@pevik>
References: <20210812043807.3497492-1-lkml@jv-coder.de>
 <20210812043807.3497492-2-lkml@jv-coder.de> <YR+Lc8aBnK6KBOnW@pevik>
Message-ID: <d6443e3f-9859-82ff-7ba0-f8842cd2f437@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On 8/20/2021 1:01 PM, Petr Vorel wrote:
> Hi Joerg,
>
> I suppose this one is superseded by adding volatile by Martin's fix in
> b1e7776bf ("connectors/pec_listener: Make exit_flag volatile")
No, not at all.
The first issue is a timing issue between the event generator -> kernel 
-> pec_listener,
that cannot be fixed by a volatile, only by correct synchronization.
The second issue is also unrelated.

Martin's fix is only for the rare case, where the exit_flag could be 
optimized out by the compiler,
which would have made the event_listener run forever instead of terminating.

Joerg
