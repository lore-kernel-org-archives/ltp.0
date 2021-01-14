From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 14 Jan 2021 15:09:11 +0100
Subject: [LTP] [PATCH v6 2/3] Add tst_secureboot_enabled() helper
 function
In-Reply-To: <ef29118b-436a-5d2f-1bde-2a5b3ac78290@suse.cz>
References: <20210112095759.11910-1-mdoucha@suse.cz>
 <20210112095759.11910-2-mdoucha@suse.cz>
 <YABJTK2hRHBjJ6lc@yuki.lan>
 <ef29118b-436a-5d2f-1bde-2a5b3ac78290@suse.cz>
Message-ID: <YABQh3Sd1MItrfQL@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> We could change it, but I'd prefer to know that the Efivar FS exists but
> cannnot be open()ed due to missing permissions than to mix these two
> states into the same vague info message.

Ok. Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
