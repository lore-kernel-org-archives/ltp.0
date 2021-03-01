From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 1 Mar 2021 14:24:30 +0100
Subject: [LTP] [PATCH v2 0/5] Another attempt at hardware discovery
In-Reply-To: <CAF12kFtuFvVnykBbcGsgsc_LYuh541SfA9P_RV88KzwFjuTsxg@mail.gmail.com>
References: <20210224165045.17738-1-chrubis@suse.cz>
 <CAF12kFtuFvVnykBbcGsgsc_LYuh541SfA9P_RV88KzwFjuTsxg@mail.gmail.com>
Message-ID: <YDzrDqn0eLkdBLZd@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I think this has many advantages over the first edition, In out Internal Test???
> we use a similar way to define the test prerequires as JSON structor.[1]
> here is My opinion, In the LTP testcase framework, we can set all the
> prerequires
> in a JSONfile, these prerquires include CONFIGS,  ABIs,
> devices-path(sys???proc,dev etc.),
> the SETUP stage  to check if the machine satisfy the defined-Json.
> at the same time??? we also need a scripts to generate a JSON-file from
> the current machine to collect all the prerequires list.
> In this way, the benefit not just device-driver, but alse common testcase

We actually have something like this implemented. We generate a big JSON
file on LTP build that describes the whole testsuite, but it includes
more than just pre-requisites, have a look at docparse/metadata.json
that is generated in recent LTP builds.

As for kernel config dependencies we have needs_kconfigs array, which is
actually an array of boolean expressions on kernel config options where
each of them has to be true in order for a test to continue. So to find
out if we have a suitable kernel config for a test we have to check if
all are true in:

"tests": {
	"test_name": {
		"needs_kconfigs": [
			"CONFIG_FOO=y | CONFIG_BAR=m",
			"!CONFIG_DAR=y"
		]
	}
}

We do not have the "file" part that would match the functionality you
have in your code but that shouldn't be hard to add.

-- 
Cyril Hrubis
chrubis@suse.cz
