From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Jan 2016 20:05:46 +0100
Subject: [LTP] [PATCH] controllers/cgroup_fj: fix failure
In-Reply-To: <1450088550-19792-1-git-send-email-chnyda@suse.com>
References: <1450088550-19792-1-git-send-email-chnyda@suse.com>
Message-ID: <20160119190545.GB17351@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +cgroup_fj_stress_devices_1_100_100_2 run_cgroup_test_fj.sh stress devices 100 100 2
                            ^
			    You forget to remove the paramter from the
			    test name.

I've pushed the test with a different changelog. It turned out, after
careful review that the testcases were actually umounting the cgroup in
the setup() function. Neverthless the code was mess so I've applied the
patch, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
