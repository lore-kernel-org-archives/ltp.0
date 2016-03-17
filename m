From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Mar 2016 17:50:20 +0100
Subject: [LTP] [PATCH RFC 5/9] ftrace_regression: add a new testcase
In-Reply-To: <1457079898-9449-6-git-send-email-liwang@redhat.com>
References: <1457079898-9449-1-git-send-email-liwang@redhat.com>
 <1457079898-9449-2-git-send-email-liwang@redhat.com>
 <1457079898-9449-3-git-send-email-liwang@redhat.com>
 <1457079898-9449-4-git-send-email-liwang@redhat.com>
 <1457079898-9449-5-git-send-email-liwang@redhat.com>
 <1457079898-9449-6-git-send-email-liwang@redhat.com>
Message-ID: <20160317165020.GF31815@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +###############################################################################
> +#                                                                             #
> +# Copyright (c) 2015, Red Hat Inc.                                            #
> +#                                                                             #
> +# This program is free software; you can redistribute it and/or modify it     #
> +# under the terms of the GNU General Public License as published by the Free  #
> +# Software Foundation; either version 2 of the License, or (at your option)   #
> +# any later version.                                                          #
> +#                                                                             #
> +# PURPOSE: check signal:signal_generate gives 2 more fields: grp res          #
> +#                                                                             #
> +# This testcase is verifing signal events change:                             #
> +#        6c303d3 tracing: let trace_signal_generate() report more info...     #
> +#        163566f tracing: send_sigqueue() needs trace_signal_generate() too   #
> +#                                                                             #
> +###############################################################################
> +
> +
> +# Set envent
> +echo 'signal:signal_generate' > $TRACING_PATH/set_event
> +
> +echo 1 > $TRACING_PATH/tracing_on
> +
> +echo > $TRACING_PATH/trace
> +
> +sleep 10

Why sleep 10 here?

> +grep -q 'grp=[0-9] res=[0-9]' $TRACING_PATH/trace
> +if [ $? -eq 0 ]; then
> +	exit 0
> +else
> +	exit 1
> +fi

Use test.sh and tst_resm instead.

-- 
Cyril Hrubis
chrubis@suse.cz
