From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 4 Aug 2021 17:29:36 +0200
Subject: [LTP] [PATCH v2 1/2] Add test for CVE 2020-25704
In-Reply-To: <20210803155822.1973-1-mdoucha@suse.cz>
References: <20210803155822.1973-1-mdoucha@suse.cz>
Message-ID: <YQqyYGXNpUl0ShkR@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a minor change, thanks.

> +#ifndef _PERF_EVENT_OPEN_H

Identifiers starting with single or double underscore are reserved for
system implemntation, e.g. libc so I've changed the guards just to
PERF_EVENT_OPEN_H.

-- 
Cyril Hrubis
chrubis@suse.cz
