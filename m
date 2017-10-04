From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 4 Oct 2017 14:02:40 +0200
Subject: [LTP] [PATCH 2/2] security/dirtyc0w: synchronize parent and
	child
In-Reply-To: <1300ca0b5103f4f145af3be1a0295974a04dcae8.1507113734.git.jstancek@redhat.com>
References: <94518262a76edca533440acb73611eb93184dc90.1507113734.git.jstancek@redhat.com>
 <1300ca0b5103f4f145af3be1a0295974a04dcae8.1507113734.git.jstancek@redhat.com>
Message-ID: <20171004120240.GA29423@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static const char *const resource_files[] = {
> +	TEST_APP,
> +	NULL,
> +};

I do not get why we need the test binary to be listed as resource file,
the rest seems OK to me.

-- 
Cyril Hrubis
chrubis@suse.cz
