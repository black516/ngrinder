/* 
 * Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License. 
 */
package org.ngrinder.operation;

import static org.hamcrest.Matchers.is;
import static org.junit.Assert.assertThat;

import org.junit.Test;
import org.ngrinder.AbstractNGrinderTransactionalTest;
import org.ngrinder.operation.cotroller.ScriptConsoleController;
import org.python.util.PythonInterpreter;
import org.springframework.ui.ExtendedModelMap;
import org.springframework.ui.Model;

public class ScriptConsoleControllerTest extends AbstractNGrinderTransactionalTest {

	@Test
	public void runScriptTest() {

		ScriptConsoleController scriptController = new ScriptConsoleController() {

			@Override
			protected void intVars(PythonInterpreter interp) {
			}

		};
		scriptController.init();
		String command = "print \'hello\'";
		Model model = new ExtendedModelMap();
		scriptController.runScript(command, model);
		assertThat(model.containsAttribute("result"), is(true));

	}
}
