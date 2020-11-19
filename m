From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Nov 2020 13:10:32 +0100
Subject: [LTP] [PATCH v4 1/3] Add tst_kconfig_get() helper function
In-Reply-To: <20201119115230.8829-1-mdoucha@suse.cz>
References: <20201119115230.8829-1-mdoucha@suse.cz>
Message-ID: <20201119121032.GI2785@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/**
> + * Checks kernel config for a single configuration option and returns its
> + * state if found. The possible return values are the same as for
> + * tst_kconfig_var.choice, with the same meaning. See tst_kconfig_read()
> + * description for details.
> + *
> + * @param confname The configuration option name to search for.
> + */
> +char tst_kconfig_get(const char *confname);

I do not like this interface at all since the whole kernel config is
parsed every time this function is called and I bet that people would
call it five times in a test setup() soon enough.

I guess that if you want easier interface than the tst_kconfig_read() it
should be implemented as:

* A function loads config given an array of variable names to store.
  Either it should return a handle or store the pointer to newly
  allocated data to a global variable.

* A set of functions that return variable value given variable name

* A function that frees the memory once we are done

-- 
Cyril Hrubis
chrubis@suse.cz
