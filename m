From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 4 May 2021 13:42:50 +0200
Subject: [LTP] [PATCH v2 1/1] docparse: Escape backslash,
 tab and double quote in JSON
In-Reply-To: <20210503133025.2557-1-pvorel@suse.cz>
References: <20210503133025.2557-1-pvorel@suse.cz>
Message-ID: <YJEzOoUQOP5RhdPU@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Avoid quoting new line as it's usually expected formatting,
> e.g. in .options field.

Hmm, looking at the cases that have \n in option strings it looks like a
messy hack rather than anything else...

I guess that a proper fix would be an ability to group the options, i.e.
make the .options an array of arrays so that the structures would look like:


	.options = (struct tst_option_group[]) {
		{.title = "Server", .options = (struct tst_option) {
			{"l", &foo, "Foo option help"},
			{}
		},
		...
		{}
	}


But that is something that is completely out of scope for this patch...

-- 
Cyril Hrubis
chrubis@suse.cz
