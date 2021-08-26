From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Aug 2021 15:27:38 +0200
Subject: [LTP] [PATCH v2 4/4] Add test for CVE 2018-13405
In-Reply-To: <20210826112212.26394-4-mdoucha@suse.cz>
References: <20210826112212.26394-1-mdoucha@suse.cz>
 <20210826112212.26394-4-mdoucha@suse.cz>
Message-ID: <YSeWymK0elcbiqzt@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> +/*
> + * Copyright (c) 2021 SUSE LLC <mdoucha@suse.cz>
> + *
> + * CVE-2018-13405
> + *
> + * Check for possible privilege escalation through creating files with setgid
> + * bit set inside a setgid directory owned by a group which the user does not
> + * belong to. Fixed in:
Maybe this info could be in docparse, but again, that can be fixed during merge.

Kind regards,
Petr
